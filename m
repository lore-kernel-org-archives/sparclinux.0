From: Bob Picco <bpicco@meloft.net>
Date: Wed, 10 Sep 2014 14:37:55 +0000
Subject: Re: [PATCH] sparc64: find_node adjustment
Message-Id: <20140910143755.GG17331@zareason>
List-Id: <sparclinux.vger.kernel.org>
References: <1410105066-22822-1-git-send-email-bpicco@meloft.net>
In-Reply-To: <1410105066-22822-1-git-send-email-bpicco@meloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:	[Tue Sep 09 2014, 06:20:01PM EDT]
> From: Bob Picco <bpicco@meloft.net>
> Date: Sun,  7 Sep 2014 11:51:06 -0400
> 
> > Hopefully this isn't too confusing. I'll add the reference below for those
> > with a need for further details:
> > http://psarc.us.oracle.com/FWARC/2007/260/materials/lgroups_onepager.txt
> 
> "This webpage is not available", I think you can only get at this
> from inside Oracle, and if so it's inappropriate to use it as a
> reference in a commit message.
This is unfortunate for many old SMI sites.
> 
> Anyways, as per the bug, it looks simply like node matching
> information is missing sometimes.
Okay.
> 
> Whilst unfortunate, you're right that we should code defensively and
> not fail if that happens, especially if we know that it can.
Okay.
> 
> Please respin this with the commit message adjusted, thanks.
Will respin and drop the reference and you're welcome.

thanx for the review,

bob
