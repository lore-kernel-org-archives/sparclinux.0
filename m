From: David Miller <davem@davemloft.net>
Date: Sat, 30 Mar 2013 21:46:22 +0000
Subject: Re: [PATCH 2/5] sparc: define __linux__ to fix defconfig build
Message-Id: <20130330.174622.1239599432841595206.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1364679866-29982-2-git-send-email-sam@ravnborg.org>
In-Reply-To: <1364679866-29982-2-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 30 Mar 2013 22:44:23 +0100

> The gcc version I use do not include a definition of __linux__.

Then it's not a gcc targetting Linux.
