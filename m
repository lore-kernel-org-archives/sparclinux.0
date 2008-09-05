From: Josip Rodin <joy@entuzijast.net>
Date: Fri, 05 Sep 2008 17:43:12 +0000
Subject: Re: [BUG] 2.6.26-rc1 lost half the RAM on UltraSPARC 5
Message-Id: <20080905174312.GA30239@orion.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
References: <18465.63175.561233.228014@alkaid.it.uu.se>
In-Reply-To: <18465.63175.561233.228014@alkaid.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, May 15, 2008 at 08:43:10PM +0200, Mikael Pettersson wrote:
> Thanks Dave. As the dmesg diff below shows, this patch fixed
> my lost RAM issue. I actually have about 8KB more available
> now than I had with 2.6.25.
[...]
> +Memory: 245448k available (1920k kernel code, 744k data, 152k init) [fffff80000000000,0000000017f46000]

FWIW I just happened to notice the same improvement, but the difference here
is actually considerably larger (upgrade was .22 -> .26):

-Memory: 243016k available (2096k kernel code, 760k data, 96k init) [fffff80000000000,0000000017f40000]
+Memory: 248928k available (2128k kernel code, 800k data, 120k init) [fffff80000000000,0000000017f40000]

Dave could really start charging for these hardware upgrades :)

-- 
     2. That which causes joy or happiness.
