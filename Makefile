current_branch := 0.211
build:
	docker build -t registry.advanpro.cn/prestodb:$(current_branch) ./
