#ClashOfTrolls Smart Contract

Reddit banned one of their notorious Subreddits a few years ago, today we'll try to use Ethereum network to rebuild that subreddit as a DAPP using Ethereum to avoid censorship. The subreddit was called /r/GameOfTrolls.

Quoting /u/hi_internet:

> They made a game to troll Reddit and had goals and points that you would earn for creating a troll post. If you completed certain goals, you would gain points. For instance, if someone gave you gold for your post you would gain points or if a moderator demodded themselves because of the controversy you would also gain points. If someone identifies you as a troll you would lose points and so forth. Your total was scored and posted to the /r/gameoftrolls subreddit when the drama subsided so people could take a look at your achievement. From there onwards, the people with the highest scores were put on a leaderboard in the sidebar.

> It was all in good fun. One memorable post was a guy who posted to askreddit pretending to be someone with a coworker problem.The story was he had a coworker who was trying too hard to be his friend and called him ugly and fat in his post and asked reddit what the best way to get rid of him was without hurting his feelings. Classic reddit ending, "co-worker" shows up in the thread, gets angry at the guy saying he's never had any friends in his life, and he thought this time it was different but he was wrong. Reddit believes the heartfelt story for an entire week and sends the guy messages, flowers, marriage proposals, etc. Guy who fabricated the story then posts to Game of trolls for his points, it was glorious.

> That was one of the better posts though, sometimes moderators were demodded and huge amounts of drama and butt hurt ensued for some posts. I still stand by the fact it was all in good fun, people take the Internet way too seriously sometimes.


TL;DR: GameOfTrolls subreddit was aimed at lying on the Internet and making a game out of it. It enabled the worst possible crime on the Internet. So we are going to do the logical thing and resuscitate it via a DAPP.

##Version 1

The simplest implementation of ClashOfTrolls contract would be to reward any account who posts a URL of the Reddit thread and can post a certain text from that account.

Pros: It allows people to fund a prize money to be given to anyone who can show ownership of an account with a lot of 'upvotes' on Reddit.

Problem: This can technically allow anyone to claim ClashOfTrolls award as long as they do it the same time (or in some race condition) as the original troll.

In fact, you can't even accept the previous or next value of the claim request.

**Status:** Implemented, going through refactor and unit testing.

[ClashOfTrolls.sol](https://github.com/prashantpawar/ClashOfTrolls/blob/master/contracts/ClashOfTrolls.sol) - The implemented contract.

[Tugboat.sol](https://github.com/prashantpawar/ClashOfTrolls/blob/master/contracts/Tugboat.sol) - For managing and updating ClashOfTrolls contract.

##Version 2
To deal with race conditions, we give a certain random key to be posted from the claimant's account, but the problem is that this allows others to figure out that a certain account is a CoT account. Not to mention, this does not prevent people from making false claims via their legit threads just to drain out the CoT funds.

Another problem is that the key cannot be easily randomized and might be predictable. One solution to that is to allow user to enter a key which he or she will use to demo the ownership of the account. But that brings us to the limitations that anybody can analyze the key and figure out the Troll.

Implementation 3: To deal with the problem of non-trolls claiming the prize money, we can make the rules such a way that the troll must register himself to the DAPP before he or she makes the troll attempt. The token would be valid for 6 months. After that the prize cannot be claimed and is returned to the funders.

Right now, hiding in plain sight is still a problem. If we store the username under which the troll attempt will be made then anyone will be able to find out the trolls before the troll attempts happen. Similarly if we don't store any identifiable information, then anyone (specifically non-trolls) will be able to claim the rewards. So how can we create an open authentication system for whistleblowers.

**Status:** Planning
