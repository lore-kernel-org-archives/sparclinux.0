From: David Miller <davem@davemloft.net>
Date: Fri, 06 Jun 2008 10:18:45 +0000
Subject: Re: [RFC] unify exported sparc header files?
Message-Id: <20080606.031845.193710152.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080601072044.GA16220@uranus.ravnborg.org>
In-Reply-To: <20080601072044.GA16220@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 5 Jun 2008 22:25:18 +0200

> Half of this is trivial differences but anyway more work than
> I initially anticipated :-(

Things are never as simple as they initially seem. :)

BTW, the correct test for 64-bit sparc in userspace
is something like:

#if defined(__sparc__) && defined(__arch64__)

That "__sparc_v9__" is a deprecated old cpp define which
shouldn't be used in new files.
