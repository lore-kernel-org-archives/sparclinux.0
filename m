From: Bob Picco <bpicco@meloft.net>
Date: Thu, 18 Sep 2014 18:13:21 +0000
Subject: Re: [PATCH] sparc64: valid physical address bitmap
Message-Id: <20140918181321.GS17331@zareason>
List-Id: <sparclinux.vger.kernel.org>
References: <1410886337-16116-1-git-send-email-bpicco@meloft.net>
In-Reply-To: <1410886337-16116-1-git-send-email-bpicco@meloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:	[Thu Sep 18 2014, 01:13:22PM EDT]
> From: Bob Picco <bpicco@meloft.net>
> Date: Thu, 18 Sep 2014 06:16:06 -0400
> 
> > The machine has more reg property entries than this kernel can
> > support (32).
> 
> Bob, is there some upper bound we can use?  I'm happy to enlarge it
> to whatever reasonable size is necessary.
I just sent an email because my knowledge isn't LDOM guest.
> 
> The 'memory' node properties are the one thing I don't think we can
> reasonably dynamically allocate memory for, so they have to be
> statically sized.
I agree.
> 
> With the changes we are discussing here, we are getting several
> megabytes of BSS space back in the kernel image, so there is lots
> of room for expanding the value of MAX_BANKS :-)
Indeed.
> 
> Also, that debugging message from read_obp_memory() should also
> print out "ents" so we know how much we might need to expand it
> in the future.
Yes.
