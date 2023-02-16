# this script is a part of pacbio amplicon analysis pipeline
# it calculates the proportion of reads mapped back to consensus sequences
# author: Yue (Gary) Zhang, PhD

## Load packages ----------------
packages_to_load = c('dplyr')
lapply(packages_to_load, require, character.only = TRUE)

## read the input
args <- commandArgs(trailingOnly = TRUE)

idx = read.csv(args[[1]], sep = '\t', header = F)
hifi = read.csv(args[[2]], sep = '\t', header = T)
bed = read.csv(args[[3]], sep = '\t', header = F)
outputfile = args[[4]]
samplename = gsub('.*/','',gsub('\\..*','', args[[2]]))
print(args[[1]])
print(args[[2]])
print(args[[3]])
print(samplename)
print(outputfile)
# idx = read.csv('ALL_Hifi_reads_to_CONCAT_DEREP_cluster_sequences_primary_alignment_idxstat.txt', sep = '\t', header = F)
# hifi = read.csv('m64467e_221028_083113_hifistat.txt', sep = '\t', header = T)
# bed = read.csv('CONCAT_DEREP_passed_cluster_sequences.spike_gene.bed', sep = '\t', header = F)
## data processing
names(idx) = c('consensus sequence', 'length_bases', 'Nreads', 'frequency')
idx = subset(idx, `consensus sequence` != "*")
idx_unmapped = c('unmapped', NA, hifi$num_seqs - sum(idx$Nreads), NA)
idx_total = c('total', hifi$avg_len,hifi$num_seqs,NA)
idx = rbind(idx,idx_unmapped,idx_total)
idx[,2:4] = as.data.frame(lapply(idx[,2:4], as.numeric))
idx$frequency = idx$Nreads/hifi$num_seqs
str(idx)
bed = bed[,1:4]
names(bed) = c('reference','start','end','consensus sequence')
idxbed = merge(idx,bed, by = 'consensus sequence', all.x = T, all.y = T)
idxbed$sample = samplename
idxbed = idxbed[,c(ncol(idxbed),1:ncol(idxbed)-1)]
if (idx$frequency[idx$`consensus sequence` == 'total'] == 1) {
  write.csv(idxbed, outputfile, quote = F, row.names = F)
} else {
  idxbed = data.frame(Error = 'error in downstream processing')
  write.csv(idxbed, outputfile, quote = F, row.names = F)
}
