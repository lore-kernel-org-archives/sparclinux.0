From: Christoph Hellwig <hch@lst.de>
Date: Wed, 09 May 2018 13:59:41 +0000
Subject: make a few block drivers highmem safe
Message-Id: <20180509135948.20329-1-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jens Axboe <axboe@kernel.dk>
Cc: "Ed L. Cashin" <ed.cashin@acm.org>, Geoff Levand <geoff@infradead.org>, Maxim Levitsky <maximlevitsky@gmail.com>, linux-block@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mtd@lists.infradead.org, sparclinux@vger.kernel.org

Hi all,

this series converts a few random block drivers to be highmem safe,
in preparation of eventually getting rid of the block layer bounce
buffering support.
