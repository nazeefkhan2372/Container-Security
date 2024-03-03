# Change your SID to your own one
SID=u5579496
NAME=csvs_webserver
ALL:
	docker build -t $(SID)/$(NAME)_i .
run:
	docker run -d --net $(SID)/csvs_dbserver_net --ip 203.0.113.200 --hostname www.cyber23.test --add-host db.cyber23.test:203.0.113.201 -p 80:80 --name $(SID)_$(NAME)_c $(SID)/$(NAME)_i

clean:
	-docker kill $(SID)_$(NAME)_c
	-docker rm $(SID)_$(NAME)_c
	-docker network rm $(SID)/csvs_dbserver_net
