From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Wed, 31 Dec 2003 23:26:20 +0000
Subject: Re: socal
Message-Id: <20031231232620.GB16561@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
References: <200312311429.26841.awirtz@novapointe.com>
In-Reply-To: <200312311429.26841.awirtz@novapointe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Dec 31, 2003 at 11:07:09PM +0000, C.Newport wrote:

> Have you tried checking the firmware Fcode ?.
> http://www.splack.org/fibrechan.html has the procedure for the soc
> cards, the socal stuff is very similar.

You cannot update the fcode in the onboard socal devices on Ex500
using ssaadm.  The fcode is contained within the main PROM for these
systems, of which the latest version is 3.2.30.

-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
	"May Buddha bless all stubborn people!"
				-- Uliassutai Karakorum Blake
