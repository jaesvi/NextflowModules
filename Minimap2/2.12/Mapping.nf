fastq="/home/jvalleinclan/work/sharc/test_data/fastq_0.fastq"
sample_id = "test_sid"
rg_id = "test_rgid"

process Minimap2Mapping {
    tag {"Minimap2 ${sample_id} - ${rg_id}"}
    label 'Minimap2_2_12'
    label 'Minimap2_2_12_Map'
    container = 'quay.io/biocontainers/minimap2:2.12--ha92aebf_0'
    shell = ['/bin/bash', '-euo', 'pipefail']

    input:
        tuple (sample_id, rg_id, path(fastq))

    output:
        tuple (sample_id, rg_id, path("{rg_id}.bam"), emit: mapped_bams)

    script:
        def barcode = rg_id.split('_')[1]
        def minimap2_readgroup = "\"@RG\\tID:${rg_id}\\tSM:${sample_id}\""

        """
        minimap2 $params.optional -t ${task.cpus} -R $minimap2_readgroup $params.genome_fasta $fastq
        """
}