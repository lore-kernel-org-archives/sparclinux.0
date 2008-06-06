From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 06 Jun 2008 21:10:31 +0000
Subject: Re: [PATCH 20/21] sparc: copy sparc64 header files to asm-sparc
Message-Id: <20080606211031.GA5093@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1212786033-4227-20-git-send-email-sam@ravnborg.org>
In-Reply-To: <1212786033-4227-20-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Jun 06, 2008 at 11:00:32PM +0200, Sam Ravnborg wrote:
> Several header files had non-trivial differences between
> the 32 and 64 bit version.
> To better support further unification create a _32.h
> file for the orginal 32 bit version and likewise a _64.h
> for the original 64 bit version.
> To spot potential unification is now a simple:

I lost most of my changelog here.
I will repost this patch.

	Sam
