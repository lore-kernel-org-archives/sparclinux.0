From: carbonated beverage <ramune@net-ronin.org>
Date: Mon, 22 Mar 2004 04:38:37 +0000
Subject: Unable to build 2.6.4 w/o CONFIG_INPUT
Message-Id: <20040322043836.GA19635@net-ronin.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I have a headless box that's only used over the network and via serial
console, but if I remove CONFIG_INPUT, the kernel doesn't get built
correctly during "make image".

I tried modifying CONFIG_VT directly in .config and doing a make oldconfig,
but it seems to always get set to y.

-- DN
Daniel
