From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 21 Dec 2009 06:12:25 +0000
Subject: Re: [PATCH 1/2] sparc: us3_cpufreq.c: fix warnings/errors
Message-Id: <20091221061225.GA20054@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1261311396-609-1-git-send-email-a.beregalov@gmail.com>
In-Reply-To: <1261311396-609-1-git-send-email-a.beregalov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Dec 20, 2009 at 03:16:35PM +0300, Alexander Beregalov wrote:
> Fix warnings which become build errors since -Werror is used.
> arch/sparc/kernel/us3_cpufreq.c:60: error: 'ret' may be used uninitialized in this function
> arch/sparc/kernel/us3_cpufreq.c:101: error: 'new_bits' may be used uninitialized in this function

What config produces these warnings?
Do you have CONFIG_BUG_VERBOSE set?

Also what gcc versio?

	Sam
