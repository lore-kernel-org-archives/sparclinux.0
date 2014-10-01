From: David Miller <davem@davemloft.net>
Date: Wed, 01 Oct 2014 20:42:01 +0000
Subject: Re: [PATCH v2 0/8] sparc64: MM/IRQ patch queue.
Message-Id: <20141001.164201.921968113910937236.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20140927.142812.2031647355756795530.davem@davemloft.net>
In-Reply-To: <20140927.142812.2031647355756795530.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bob Picco <bpicco@meloft.net>
Date: Wed, 1 Oct 2014 10:29:00 -0400

> [root@ca-qasparc24 ~]# Unable to handle kernel NULL pointer dereference
> BUG: Bad page map in process cc1  pte:9800003fdd860690 pmd:183f3f4b6000
> page:000600007fbb0c00 count:107055216 mapcount:-524287 mapping:          (null) index:0xfff8000107659c00
> page flags: 0x6c4b6e00004f56(error|referenced|dirty|active|owner_priv_1|arch_1|reserved|private|head)
> page dumped because: bad pte

The first thing I notice is that the count, mapcount, and flags are all garbage.

But not just random garbage, all of the non-zero bytes in the page
flags are in visible the ASCII character range.

0x6c = 'l'
0x4b = 'K'
0x6e = 'n'
0x4f = 'O'
0x56 = 'V'

Anyways, just FYI...
