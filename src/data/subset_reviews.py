import pandas as pd
import csv

# reader for reviews
review_header = pd.read_csv('../../data/interim/review.csv', nrows = 0)
review_rdr = pd.read_csv('../../data/interim/review.csv', chunksize = 10 ** 5 * 2)

# read in restaurants
print('Read in restaurants file')
restaurants = pd.read_csv('../../data/processed/restaurants.csv', usecols = ['business_id'])

# read in reviews and only keep those for restaurants in big cities
# write header row
print('Write header row of restaurant reviews file')
rreviews_csv = '../../data/processed/restaurant_reviews.csv'
outputcsv = open(rreviews_csv, 'w')
csvwriter = csv.writer(outputcsv)
csvwriter.writerow(list(review_header))
outputcsv.close()

print('Write header row of restaurant reviews sample file')
rreviews_sample_csv = '../../data/processed/restaurant_reviews_sample.csv'
outputcsv = open(rreviews_sample_csv, 'w')
csvwriter = csv.writer(outputcsv)
csvwriter.writerow(list(review_header))
outputcsv.close()

#rreviews = pd.DataFrame()
count = 0

# merge and write restaurant reviews to csv
print('Write restaurant reviews file')
with open(rreviews_csv, 'a') as f:
	for lines in review_rdr:
		data = pd.merge(lines, restaurants, on = 'business_id', how = 'inner')
		data.to_csv(f, header = False)
		count += data.size
		print('Processed {0} reviews'.format(count))
		
print('Finished output of {0}').format(rreviews_csv)

# new reader
review_rdr = pd.read_csv('../../data/interim/review.csv', chunksize = 10 ** 5 * 2)

# merge and write restaurant reviews to csv
print('Write restaurant reviews sample file')
with open(rreviews_sample_csv, 'a') as f:
	for lines in review_rdr:
		data = pd.merge(lines, restaurants, on = 'business_id', how = 'inner')
		data.sample(frac = .5).to_csv(f, header = False)
		count += data.size
		print('Processed {0} reviews'.format(count))

print('Finished output of {0}').format(rreviews_sample_csv)
