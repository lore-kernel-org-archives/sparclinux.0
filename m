From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Date: Sat, 02 Jun 2007 18:03:34 +0000
Subject: Alignment question, sparc-centric
Message-Id: <Pine.LNX.4.61.0706022001330.5076@yvahk01.tjqt.qr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,


I was just wondering, since sparc is one of these alignment-sensitive 
architectures, is it actually valid to dereference at odd positions, 
e.g...?

  *(uint16_t *)uint8_ptr[something_not_divisible_by_2];
  *(uint32_t *)uint8_ptr[something_not_divisible_by_4];
  etc.


	Jan
-- 
