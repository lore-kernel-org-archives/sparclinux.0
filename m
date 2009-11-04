From: David Miller <davem@davemloft.net>
Date: Wed, 04 Nov 2009 13:41:42 +0000
Subject: Re: [PATCH 1/2] Added sparc_leon3_snooping_enabled()
Message-Id: <20091104.054142.58731691.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1257172092-25026-1-git-send-email-kristoffer@gaisler.com>
In-Reply-To: <1257172092-25026-1-git-send-email-kristoffer@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Kristoffer Glembo <kristoffer@gaisler.com>
Date: Mon,  2 Nov 2009 15:28:11 +0100

> Added a function for checking if snooping is enabled.

You need to provide a proper "Signed-off-by:" when submitting patches.

Also, all of these inline routines in leon.h should be
"static inline" not "extern inline".

"extern inline" tells the compiler that it can choose to not
inline the function, and that externally in some other object
file an implementation of that function will exist that the
compiler can generate a call to.

You want "static inline" which tells the compiler that it either
must inline the function or emit a local static copy of it into
the current compilation unit.
