From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 30 Sep 2016 04:29:59 +0000
Subject: Re: [PATCH] Sparc/prom/ranges.c cosmetic improvement
Message-Id: <20160930042959.GA29708@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20160928214625.GA24725@netmonk.localdomain>
In-Reply-To: <20160928214625.GA24725@netmonk.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> 
> Thank you for the correction. 
> Can i resubmit the patch in reply of this thread, or do i need to create a new thread ?

Both will work - but in this case just create a
new thread - and mark the patch as v2:

[PATCH v2] sparc: bla bla


And in the changelog part of the patch do:

bla bla
More bla bla
---

v2:
Fixed indent..

Keep version information below the "---" marker.
So the version information is not part of the final commit message.

	Sam

