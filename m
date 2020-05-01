From: Matthew Wilcox <willy@infradead.org>
Date: Fri, 01 May 2020 15:23:42 +0000
Subject: Re: [PATCH 1/4] fs: Implement close-on-fork
Message-Id: <20200501152342.GA29705@bombadil.infradead.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20200420071548.62112-1-nate.karstens@garmin.com>
 <20200420071548.62112-2-nate.karstens@garmin.com>
 <36dce9b4-a0bf-0015-f6bc-1006938545b1@gmail.com>
 <0e884704c25740df8e652d50431facff@garmin.com>
In-Reply-To: <0e884704c25740df8e652d50431facff@garmin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Karstens, Nate" <Nate.Karstens@garmin.com>
Cc: Eric Dumazet <eric.dumazet@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, Arnd Bergmann <arnd@arndb.de>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.ke>

On Fri, May 01, 2020 at 02:45:16PM +0000, Karstens, Nate wrote:
> Others -- I will respond to feedback outside of implementation details in a separate message.

FWIW, I'm opposed to the entire feature.  Improving the implementation
will not change that.
