#LOYAL USERS REWARD

use ig_clone;

select users.id, users.username, users.created_at
from users
order by created_at ASC
limit 10;

#chcek user engagement
select users.id, users.username, photos.user_id,photos.image_url
from users
left join photos on photos.user_id = users.id
where photos.user_id is null;
# most ikes on photos
select users.username, count(likes.user_id) as highest_likes , photos.image_url
from users
join photos on users.id = photos.user_id
join likes on photos.id = likes.photo_id
group by users.username, photos.image_url
order by highest_likes desc
limit 1;

#hashtags research
select tags.id, tags.tag_name, count(photo_tags.photo_id) as highest_tags
from tags
join photo_tags on tags.id = photo_tags.tag_id
group by tags.tag_name
order by  highest_tags desc
limit 10;

#ad campaign launch
select dayname(created_at) as best_days, count(users.id) as resgistration_counts
from users
group by best_days
order by resgistration_counts desc;

#user engagement
select count(photos.id)/(select count(*)from users) as average_count_users
from photos;

#determine the accounts are fake or bots
select likes.user_id as fake_accounts , users.username as fake_names
from likes
join users on likes.user_id = users.id 
group by user_id, fake_names
having count(distinct photo_id)=(select count(photos.user_id) from photos)
