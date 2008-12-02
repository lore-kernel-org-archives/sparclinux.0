From: David Miller <davem@davemloft.net>
Date: Tue, 02 Dec 2008 07:23:00 +0000
Subject: GIT tree plans
Message-Id: <20081201.232300.105915235.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


After Linus takes in the bug fixes I just sent to him I am
going to rebase the sparc-next-2.6 tree.

I normally wouldn't do this but there is a generic Makefile
change from Sam that causes a bad bisection point for non-
sparc systems so it's a good idea to get rid of that.

I normally wouldn't respin the tree like this, but to cure this
I think it's worth it.
