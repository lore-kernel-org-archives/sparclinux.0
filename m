From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Date: Mon, 13 Jul 2009 06:33:55 +0000
Subject: Re: sparc32 dma-debug found bug?
Message-Id: <20090713153307Y.fujita.tomonori@lab.ntt.co.jp>
List-Id: <sparclinux.vger.kernel.org>
References: <4A53DCD9.30104@earthlink.net>
In-Reply-To: <4A53DCD9.30104@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, 07 Jul 2009 19:40:09 -0400
Robert Reif <reif@earthlink.net> wrote:

> I have the latest dma debug patches from FUJITA Tomonori
> and http://patchwork.kernel.org/patch/33866/ running on
> sparc32 and it looks like it might have found an issue at
> boot time:

I've not read the thread but the above patch seems totally wrong.

Seems that Ingo merged the fix to mainline (commit
f39d1b9792881ce4eb982ec8cc65258bf95674b5).

I've just submitted the second version and uploaded the git tree
(against the latest git):

git://git.kernel.org/pub/scm/linux/kernel/git/tomo/linux-2.6-misc.git sparc

