From: "David S. Miller" <davem@redhat.com>
Date: Fri, 27 Aug 2004 00:06:39 +0000
Subject: Re: [PATCH] fix bug in sparc64 user copy patch
Message-Id: <20040826170639.130f54fd.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040820155250.69c09781.davem@redhat.com>
	<412E7730.4050309@triplehelix.org>
In-Reply-To: <412E7730.4050309@triplehelix.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joshua Kwan <joshk@triplehelix.org>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 26 Aug 2004 16:50:08 -0700
Joshua Kwan <joshk@triplehelix.org> wrote:

> 1) clears the screen twice right after Remapping the kernel...

No idea.

> 2) omits every other character when it does start printing messages? such as

You're not following the list I guess...  I even posted about
this to debian-sparc, ho hum.

There is a problem with sunsab serial consoles, we're still
trying to figure out exactly what.  Note that console output
starts working properly once userland starts up.
