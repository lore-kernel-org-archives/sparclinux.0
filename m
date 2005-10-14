From: Peter Jones <pjones@redhat.com>
Date: Fri, 14 Oct 2005 21:07:43 +0000
Subject: Re: qlogicpti kernel panic
Message-Id: <1129324063.5334.9.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <1129315998.2243.35.camel@localhost.localdomain>
In-Reply-To: <1129315998.2243.35.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, 2005-10-14 at 17:04 -0400, Peter Jones wrote:

> The closest thing I see to something that does something like this, but
> handles both sg and a single buffer is scsi_debug.c's
> fill_from_dev_buffer (which is of course not exported, nor should it
> be).
> 
> Is the right way something along those lines?

Ok, I see that your patch does something like that ;)
-- 
  Peter

