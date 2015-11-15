#!/usr/bin/python

from locust import HttpLocust, TaskSet, task

class MyTaskSet(TaskSet):

    @task
    def profile(self):
         self.client.get('/app/loadavg', verify=False)

class MyLocust(HttpLocust):
    task_set = MyTaskSet
    min_wait=5000
    max_wait=9000

