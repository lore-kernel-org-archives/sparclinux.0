From: "David S. Miller" <davem@davemloft.net>
Date: Tue, 16 Nov 2004 22:51:12 +0000
Subject: Re: Strange mapping in Qemu
Message-Id: <20041116145112.2217a2d9.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <BAY12-F7stPGtPrPrvC00075903@hotmail.com>
In-Reply-To: <BAY12-F7stPGtPrPrvC00075903@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, 16 Nov 2004 22:53:52 +0100
"Blue Swirl" <blueswir1@hotmail.com> wrote:

> ... the page tables are OK and Linux reaches con_init()!

Great news :-)

Well, if swap was broken maybe you should check out that
ldstub is ok too :-)
