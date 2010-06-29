From: Andres Salomon <dilinger@queued.net>
Date: Tue, 29 Jun 2010 01:54:07 +0000
Subject: [PATCH 0/4] RFC: OLPC/x86 device tree code
Message-Id: <20100628215407.2017bf2f@debian>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: devicetree-discuss@lists.ozlabs.org
Cc: sparclinux@vger.kernel.org, x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, cjb@laptop.org, Mitch Bradley <wmb@laptop.org>, pgf@laptop.org, linux-kernel@vger.kernel.org, davem@davemloft.net, grant.likely@secretlab.ca

Hi,

I'm looking for input on the following patches; they're based upon the
OFW patch that's currently in the x86-tip tree[0], and they've only been
compile tested (on x86 and sparc64).  This stuff takes the sparc
device tree creation code and makes it available for multiple
architectures, which OLPC then makes use of to build the tree.
There's still a bunch of little stuff that I need to fix (and of
course, I need to verify that it actually remains compatible w/ the
old promfs code that OLPC's been using[1]).

[0]
http://git.kernel.org/?p=3Dlinux/kernel/git/mingo/linux-2.6-x86.git;a=3Dcom=
mit;h=FD699c76552bb

[1]
http://dev.laptop.org/git/olpc-2.6/commit/?id=0B9734dc5f0b3d24e8f3dfedaeacb=
61675c838ff
