From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 06 Jan 2009 20:44:04 +0000
Subject: Re: [PATCH 0/5] Eliminate most of sparc_ksyms_*.c
Message-Id: <20090106204404.GD17714@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <4963717C.8080008@gmail.com>
In-Reply-To: <4963717C.8080008@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Jan 07, 2009 at 01:58:04AM +1100, Julian Calaby wrote:
> Hi all,
> 
> This patch set eliminates most of the definitions within 
> arch/sparc/kernel/sparc_ksyms_*.c by moving them to their rightful places.
> 
> This is done within patches 1-3.
> 
> Note that this work was originally performed by Sam Ravnborg and these 
> patches have been rebased and added to by myself.
> 
> I've tried to reflect this in the commit messages but may have gotten it 
> a little wrong.
> 
> Patches 4 and 5 are cleanups that I had in my tree for an eventual 
> oplib_*.h unification - but as this screws up my original patches and 
> they're so small, I figured this'd be as good a time as any to send them.

Hi Julian.

I appreciate you took over this patch-set - thanks!

I have not yet looked over the patches. But at first glance it looked
like they were word-wrapped??
Anyway - I will let you know if/when I get to it.

	Sam
