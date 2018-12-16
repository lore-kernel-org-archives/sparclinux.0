From: Christoph Hellwig <hch@lst.de>
Date: Sun, 16 Dec 2018 09:57:53 +0000
Subject: fix sparc32 ->map_sg regression
Message-Id: <20181216095755.10503-1-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Thanks to Guenther for reporting and providing a qemu root image
to reproduce.
