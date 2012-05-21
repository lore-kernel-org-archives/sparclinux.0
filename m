From: David Miller <davem@davemloft.net>
Date: Mon, 21 May 2012 21:15:20 +0000
Subject: [README] sparc-next merged...
Message-Id: <20120521.171520.1063606585445461458.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Linus has pulled in all of the sparc-next changes into his tree.
I have therefore fast-forwarded both 'sparc' and 'sparc-next' to
the head of his tree.

'sparc-next' is now frozen and no developer should occur against it
until it is reopenned some time after the merge window is over.

All changes should be bug fixes and made against the 'sparc' tree.

I am going to allow Sam to finish his de-LEON'ization work and will
merge it in via the 'sparc' tree, because these changes will
significantly increase the maintainability of the tree.
