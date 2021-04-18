import json

with open('json datasets/drivers.json', encoding="utf8") as f:
	drivers = json.load(f)

with open('json datasets/races.json', encoding="utf8") as f:
	races = json.load(f)

with open('json datasets/results.json', encoding="utf8") as f:
	results = json.load(f)

dataset = results.copy()

def getRaceRecordById(id):
	for race in races['items']:
		if race['raceid'] == id:
			return race

def getDriverRecordById(id):
	for driver in drivers['items']:
		if driver['driverid'] == id:
			return driver

for result in dataset['items']:
	result['race'] = getRaceRecordById(result['raceid'])
	result['driver'] = getDriverRecordById(result['driverid'])
	print(result)

with open('results.json', 'w') as json_file:
  json.dump(dataset, json_file)