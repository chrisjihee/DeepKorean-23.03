from chrislab.common.util import BaseProjectEnv
from chrislab.ratsnlp import cli
from ratsnlp.nlpbook.classification.arguments import ClassificationDeployArguments

config = ClassificationDeployArguments(
    env=BaseProjectEnv(project_name="DeepKorean"),
    pretrained_model_path="model/pretrained/KcBERT-Base",
    downstream_model_home="model/finetuned/nsmc",
    downstream_model_file=None,
    max_seq_length=128,
).save_working_config()

cli.serve(config)