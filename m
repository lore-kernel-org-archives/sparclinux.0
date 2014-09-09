From: Bob Picco <bob.picco@oracle.com>
Date: Tue, 09 Sep 2014 21:15:04 +0000
Subject: Re: [PATCH] sparc64: mem boot option correction
Message-Id: <20140909211504.GP24131@zareason>
List-Id: <sparclinux.vger.kernel.org>
References: <1410105147-23085-1-git-send-email-bpicco@meloft.net>
In-Reply-To: <1410105147-23085-1-git-send-email-bpicco@meloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:	[Tue Sep 09 2014, 03:24:03PM EDT]
> From: Bob Picco <bpicco@meloft.net>
> Date: Sun,  7 Sep 2014 11:52:27 -0400
> 
> > +	for_each_free_mem_range(i, any_nid, &pa_start, &pa_end, &nid) {
> > +		available = available + (pa_end  - pa_start);
> > +	}
> 
> Single statement basic blocks should not be enclosed with curly
> braces, thanks.
I'll fix it up.

you're welcome and thanx for the review,

bob
