From: Raymond Burns <rayburns@comcast.net>
Date: Thu, 29 Jun 2006 22:19:15 +0000
Subject: Re: [PATCH] sparc: remove sunzilog_console_init
Message-Id: <Pine.LNX.4.10.10606291451070.16067-100000@coalcreekmill.cm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20060628141601.GA31139@palantir8>
In-Reply-To: <20060628141601.GA31139@palantir8>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi

On further review, console_init is called at an inapropriate time,
prior to probing the prom for zilog serial ports

On the other hand, SUNZILOG_CONSOLE is called out while probing /
performing initialization of the serial ports.

Your solution appears correct.


Thanx
  Ray



