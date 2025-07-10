#!/bin/bash

#SBATCH -c 8
#SBATCH --mem=8GB
#SBATCH -p gpu-preempt
#SBATCH -G 1
#SBATCH --time 09:00:00
#SBATCH -o %j_data_seed_bs64_eval.out
#SBATCH --mail-type END


# Evaluation results for our the models that change the data seed only 

EVAL_RESULTS_CSV=data/evaluation_results/aggregate_metrics/data_seed_bs64_eval.csv
DETAILED_RESULTS_DIR=data/evaluation_results/detailed_predictions
DATA_DIR=data/buckeye

module load conda/latest
conda activate ./env_cuda124

multipa-evaluate --local_models \
 data/models/data_seed_bs64_1/wav2vec2-large-xlsr-53-buckeye-ipa \
 data/models/data_seed_bs64_2/wav2vec2-large-xlsr-53-buckeye-ipa \
 data/models/data_seed_bs64_3/wav2vec2-large-xlsr-53-buckeye-ipa \
 data/models/data_seed_bs64_4/wav2vec2-large-xlsr-53-buckeye-ipa \
 --eval_out $EVAL_RESULTS_CSV \
 --verbose_results_dir $DETAILED_RESULTS_DIR \
 --no_space --data_dir $DATA_DIR
