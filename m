From: David Miller <davem@davemloft.net>
Date: Mon, 19 Nov 2018 02:59:22 +0000
Subject: Re: [PATCH] arch/sparc: Use kzalloc_node
Message-Id: <20181118.185922.1427491199237345438.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <5bdd3128.1c69fb81.4bd46.f7ce@mx.google.com>
In-Reply-To: <5bdd3128.1c69fb81.4bd46.f7ce@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sabyasachi.linux@gmail.com
Cc: khandual@linux.vnet.ibm.com, jrdr.linux@gmail.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, brajeswar.linux@gmail.com

From: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Date: Sat, 3 Nov 2018 10:54:52 +0530

> Replaced kmalloc_node + memset with kzalloc_node
> 
> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>

Applied.
