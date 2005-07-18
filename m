From: Nishanth Aravamudan <nacc@us.ibm.com>
Date: Mon, 18 Jul 2005 23:14:00 +0000
Subject: Re: [patch 3/4] sbus/bpp: remove sleep_on() usage
Message-Id: <20050718231400.GD4205@us.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20050306222904.42ED41F1F0@trashy.coderock.org>
In-Reply-To: <20050306222904.42ED41F1F0@trashy.coderock.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 18.07.2005 [15:40:48 -0700], David S. Miller wrote:
> From: domen@coderock.org
> Date: Mon, 20 Jun 2005 23:50:34 +0200
> 
> > Use wait-queue directly instead of the deprecated sleep_on()
> > function. This required adding a local wait-queue.
> > 
> > Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
> > Signed-off-by: Domen Puncer <domen@coderock.org>
> 
> This patch no longer applies, the current snooze() implementation
> does a schedule_timeout() which seems fine.

Yup, that's fine. Thanks for the responses, David.

-Nish
