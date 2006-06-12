From: Raymond Burns <rayburns@comcast.net>
Date: Mon, 12 Jun 2006 00:16:48 +0000
Subject: 2.6.17-rc6 for_each_online_cpu
Message-Id: <Pine.LNX.4.10.10606111856140.11270-100000@coalcreekmill.cm.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi

1)
The use of  for_each_online_cpu  in mm/slab.c causes great distress
for a SMP box,  replacing with for_each_online_node  " is better "

2)
The rewrite of drivers/serial/sunzilog.c hammers the sun4d pretty
hard, it doesn't walk the "zs" nodes correctly.  What I have as a
patch now misses 2 of 12 serial ports, I'll send once that improves.

3)
This one pops up in the middles somewhere,

BUG: spinlock bad magic on CPU#0, swapper/1                                     
 lock: f0f00800, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0             

not sure if the truncated next line is part of it or not.

4)
Then I stumble again at the end ....

EXT2-fs error (device sdc3): ext2_check_page: bad entry in directory
#2: unalig0

(yes it's truncated on the serial console)


Suggestions welcome :)


Thanx
  Ray


