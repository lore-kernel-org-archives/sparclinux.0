From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 15 Nov 2004 23:59:07 +0000
Subject: Re: Strange mapping in Qemu
Message-Id: <20041115155907.5033c136.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <BAY12-F7stPGtPrPrvC00075903@hotmail.com>
In-Reply-To: <BAY12-F7stPGtPrPrvC00075903@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, 14 Nov 2004 22:32:58 +0100
"Blue Swirl" <blueswir1@hotmail.com> wrote:

> Maybe someone sees immediately what is wrong?

Maybe srmmu_hwprobe() is doing something wrong under qemu?
