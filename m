From: "David S. Miller" <davem@redhat.com>
Date: Wed, 25 Aug 2004 19:15:27 +0000
Subject: Re: future of drivers/fc4/
Message-Id: <20040825121527.569defa0.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <412CB453.2050504@sms-softwaretechnik.de>
In-Reply-To: <412CB453.2050504@sms-softwaretechnik.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 25 Aug 2004 08:51:00 -0700
William Lee Irwin III <wli@holomorphy.com> wrote:

> I'm trying to arrange for a recovery from the changes between 2.2 and
> 2.4 as well as those between 2.4 and 2.6... this will not be trivial to
> do. Testing and help coding would be appreciated.

FWIW, I think the bugs were introduced when I moved the fc4
drivers over to using sbus_{read,write}bwl() instead of
direct volatile pointer derefs.
