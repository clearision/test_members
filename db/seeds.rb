# Members

john = Member.create name: 'John', url: 'https://www.google.com', short_url: 'goo.gl', headings: ['Server solutions', 'Server-side logic']
jack = Member.create name: 'Jack', url: 'https://www.yahoo.com', short_url: 'ya.hoo', headings: ['SQL Databases', 'SQL Queries']
pete = Member.create name: 'Pete', url: 'https://www.bing.com', short_url: 'bi.ng', headings: ['Space shuttle program']
zoey = Member.create name: 'Zoey', url: 'https://www.duckduckgo.com', short_url: 'duck.go', headings: ['Art exhibitions', 'Painting art school']


# Friendships

Friendship.create member: john, friend: jack
Friendship.create member: john, friend: pete
Friendship.create member: jack, friend: zoey
Friendship.create member: pete, friend: zoey
