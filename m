From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 25 Apr 2005 18:54:15 +0000
Subject: Re: [PATCH 2.6] Silence missing CONFIG_ symbol noise
Message-Id: <20050425115415.126b4d74.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1109914288.17038.64.camel@localhost.localdomain>
In-Reply-To: <1109914288.17038.64.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 25 Apr 2005 07:02:50 +0200
Sam Ravnborg <sam@ravnborg.org> wrote:

> kconfig throws a warning when it see:
> 	select I386_FOO
> 
> in sparc context, because the config symbol I386_FOO is not defined.
> We do not see this with I386, cause people make sure to define all
> selected CONFIG symbols. But most other architectures suffer from this.

Thanks for the explanation.

> But the better solution would be to drop the warning from kconfig.
> I will do that next time I get around to do some kernel hacking.

Ok, thanks again.
