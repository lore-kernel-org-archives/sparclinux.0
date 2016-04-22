From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 22 Apr 2016 17:45:44 +0000
Subject: Re: [PATCH 0/5] sparc32: kgdb_32 and STRICT_MM_TYPECHECKS updates
Message-Id: <20160422174544.GA9841@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20160422173712.GA9705@ravnborg.org>
In-Reply-To: <20160422173712.GA9705@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Apr 22, 2016 at 07:37:12PM +0200, Sam Ravnborg wrote:
> A few cosmetic pathes for sparc32 follows.
> I noticed some inconsistency in kgdb_32 that triggered a few patches.
> The inconsistency in kgdb_32 turned out to have no functional impact.
> But I anyway fixed it so kgdb_32 and kgdb_64 became just a tiny
> bit more alike.
This is btw v2 of "sparc32: fix trap number in call to kgdb_handle_exception"
posted a few weeks ago.
Should have mentioned that in the original cover letter.

	Sam
