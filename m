From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 22 Jan 2008 10:51:19 +0000
Subject: Re: [PATCH] sparc64: fix of section mismatch warnings
Message-Id: <20080122105119.GA6725@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20080121202210.GA552@uranus.ravnborg.org>
In-Reply-To: <20080121202210.GA552@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> 
> I was more concerned with the larger question that contexts like this,
> assignment of __init function pointers to dynamic data structure
> members, is not checked.
> 
> The checker has no way to make sure that pbm->scan_bus() is only
> made in __init contexts, even though we can plainly see that is
> the case here.
> 
> What would be really clever would be a way to mark datastructure
> members as "this is a pointer to an __init function".

Today with the section resolution used by modpost I can annotate
the full datastructure to say that references to __*init/__*exit
should not be flagged - thedata are simply put in a dedicated section.

The more fine grained approach you are requesting needs assistance
with sparse I think.
I will explore that later when I get section mismatch stuff under control.

With section mismatch warnings being converted to errors soon
I foresee a bit nosie I need to concentrate on first.
But at least sparc64 is in pretty good shape now.


	Sam

