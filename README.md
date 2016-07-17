# DOCKER WAITER

This is an utility mean to introduce wait logic in a number of services.

The waiter can be configured for all those services through the following env vars:

* WAITER_ATTEMPTS (mandatory): Number of attempts the waiter will ping the service.
* WAITER_ATTEMPT_SLEEPTIME (mandatory): Amount of time the waiter will wait in seconds after an unsuccesful ping attempt.
* WAITER_DEBUG (optional, default: false): If true, it will show in console the response of the ping command executed on attemps, otherwise it will be hidden.

# IMAGES


### theypsilon/docker-wait-for-elasticsearch:0.1.1

Configuration of elasticsearch would be done with following vars:




### theypsilon/docker-wait-for-mysql:0.1.1

Configuration of mysql would be done with following vars:



