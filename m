From: Pasi Pirhonen <upi@centos.fi>
Date: Thu, 19 Apr 2007 09:04:09 +0000
Subject: Re: [TESTERS NEEDED]: Rewritten ESP driver
Message-Id: <20070419090409.GD6300@centos.fi>
List-Id: <sparclinux.vger.kernel.org>
References: <20070412.233350.41640545.davem@davemloft.net>
In-Reply-To: <20070412.233350.41640545.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,


On Thu, Apr 19, 2007 at 12:41:39AM -0700, David Miller wrote:
> From: Pasi Pirhonen <upi@centos.fi>
> > 
> > ... if that is clue for reason at all.
> 
> The two disks are identical except for MODE_SENSE settings printed
> here and those are just some timeout parameters and such.

That was the reason why i posted that info. Later i saw that you did
figure it out to be timing issue.

> 
> The current driver should not hit the problems you saw.  I plan
> to post in-full the current driver as a patch in a few moments,
> if you could retest this case with it, I'd really appreciate it.
> 

I'll test it when you post it. 

Other info (my .02 currency units) so far is that i did run little less
than 4 days this previously patches driver under various loads (several
times dbench 32 over two separate drives while compiling with load 20+
before this dbench load) and i didn't have any problems. It just did
the work from day to day. This is relatively short time, but it's at
my experiences so far. So at least the disk access seems to be fine a
little longer period than just booting it up.



-- 
Pasi Pirhonen - upi@iki.fi - http://pasi.pirhonen.eu/
Top-postings silently ignored
