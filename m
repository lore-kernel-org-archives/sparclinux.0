From: "C.Newport" <crn@netunix.com>
Date: Thu, 01 Jan 2004 02:06:56 +0000
Subject: Re: socal
Message-Id: <200401010206.56589.crn@netunix.com>
List-Id: <sparclinux.vger.kernel.org>
References: <200312311429.26841.awirtz@novapointe.com>
In-Reply-To: <200312311429.26841.awirtz@novapointe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thursday 01 January 2004 1:34 am, you wrote:

> I tried both of those a month ot two ago, but still no response.

Just a thought :-

The E3500 can boot from fcal, so the required code is in the OBP.
You could probably hack up a driver by calling the OBP code.
This would most probably be slow, but it is a start in the right 
direction.
The OBP is quite well documented and most of the code is in
Forth, so it should be easy to examine.


