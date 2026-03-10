install:
	pip install --upgrade pip &&\
		pip install -r requirements.txt

lint:
	pylint --disable=R,C,W0613,W0612,E0401 ml/*.py

test:
	python -m pytest tests/ -v --tb=short

format:
	black ml/*.py tests/*.py

format-check:
	black --check ml/*.py tests/*.py

# --- ML Pipeline Stages ---
preprocess:
	python ml/preprocess.py

train:
	python ml/train.py

evaluate:
	python ml/evaluate.py

serve:
	python ml/serve.py

# Run full pipeline
pipeline: preprocess train evaluate serve

# Clean generated files
clean:
	rm -rf data/processed models/checkpoints models/serving models/plots
	rm -f data/preprocessing_metadata.json models/*.json models/predict.py

all: install lint test
