process ViewUnmapped {
    tag {"Sambamba ViewUnmapped ${sample_id}"}
    label 'Sambamba_0_7_0'
    label 'Sambamba_0_7_0_ViewUnmapped'
    container = 'quay.io/biocontainers/sambamba:0.7.0--h89e63da_1'
    shell = ['/bin/bash', '-euo', 'pipefail']

    input:
    tuple sample_id, file(bam_file), file(bai_file)

    output:
    tuple sample_id, file("${bam_file.baseName}.unmapped.bam"), file("${bam_file.baseName}.unmapped.bam.bai")

    script:
    """
    sambamba view -t ${task.cpus} -f bam -F 'unmapped and mate_is_unmapped' $bam_file > ${bam_file.baseName}.unmapped.bam
    sambamba index -t ${task.cpus} ${bam_file.baseName}.unmapped.bam
    """
}
