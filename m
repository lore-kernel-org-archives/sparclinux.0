From: David Miller <davem@davemloft.net>
Date: Fri, 23 Jun 2006 09:54:50 +0000
Subject: Re: Prom console
Message-Id: <20060623.025450.74746970.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <449BB9C5.1070701@sitour.cz>
In-Reply-To: <449BB9C5.1070701@sitour.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Daniel Smolik <marvin@sitour.cz>
Date: Fri, 23 Jun 2006 11:52:05 +0200

> What does it mean ?

Your kernel made a call into the system firmware and crashed
in the firmware.

Without more of a backtrace it's impossible to diagnose this
problem.
