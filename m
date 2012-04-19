From: Konrad Eisele <konrad@gaisler.com>
Date: Thu, 19 Apr 2012 09:34:54 +0000
Subject: Re: failing kthread_create_on_node()
Message-Id: <4F8FDC3E.9030107@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4F8BED36.7000304@gaisler.com>
In-Reply-To: <4F8BED36.7000304@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


> When CPU1 comes online it is woken up. Then I end up in

Sorry, I mean:
When CPU1 comes online "its stopper thread" is woken up.


