From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 26 Feb 2011 08:53:56 +0000
Subject: Re: [PATCH] Don't build any of the sparc arch bits with -Werror
Message-Id: <20110226085356.GB23117@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1298678235-29164-1-git-send-email-dennis@ausil.us>
In-Reply-To: <1298678235-29164-1-git-send-email-dennis@ausil.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Feb 25, 2011 at 06:06:00PM -0600, Dennis Gilmore wrote:
> This is due to gcc-4.6 it throws warnings for defined but unused variables. 
> without this we cant build the kernel at all.  i have buil tested but not 
> tried to run yet

I assume you realize that the flags you remove only are relevant for
sparc specific code in the respective directories.
So we only need to fix the warnings in sparc specific arch code to
allow you to build sparc again.

I did so - see my patch.
Please test if you can build without -Werror with this patch.

Thanks,
	Sam
