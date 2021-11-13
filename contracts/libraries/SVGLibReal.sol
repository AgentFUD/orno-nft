// SPDX-License-Identifier: MIT

pragma solidity 0.8.9;

import "@openzeppelin/contracts/utils/Strings.sol";
import "@brechtpd/base64.sol";

library SVGLibReal {
    
    using Strings for uint256;

    // until stars
    string constant headDefs = "<svg xmlns='http://www.w3.org/2000/svg' width='100%' height='100%' viewBox='0 0 360 360' fill='none' stroke='#000' stroke-width='0' stroke-linecap='round' stroke-linejoin='round'> <defs> <clipPath id='center' clipPathUnits='userSpaceOnUse'> <circle cx='180' cy='180' r='140' /> </clipPath> <clipPath id='clip'> <path d='M0 0h360v360H0z' /> </clipPath> <linearGradient id='g151' gradientUnits='userSpaceOnUse' x1='0%' y1='0%' x2='0%' y2='90%'> <stop stop-color='#1589FF' offset='0' /> <stop stop-color='#000' offset='1' /> </linearGradient> <path id='text' d='M 180 180 m -172 0 a 170 170 0 1 0 342 0 a 170 170 0 1 0 -342 0' /> <path id='flips' d='M 69 121 C 93 84 98 82 142 58' /> <path id='io' d='M 181 318 C 239 320 312 266 326 236' /> </defs>";
    string constant style = "<style> @font-face { font-family: 'WF'; src: url(data:application/font-woff2;charset=utf-8;base64,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) format('woff2'); } .circle { animation: circle 60s infinite normal linear; transform: rotate(0deg); transform-origin: 180px 180px; } @keyframes circle { from { transform: rotate(0deg); } to { transform: rotate(360deg); } } </style>";
    string constant stars = "<g clip-path='url(#clip)'> <path fill='#000' opacity='.1' d='M0 0h360v360H0z' /> <circle cx='180' cy='180' r='180' fill='#fff' /> </g> <g clip-path='url(#center)' stroke-width='.5'> <g> <rect width='100%' height='100%' fill='black' /> <rect x='0' y='60%' width='100%' height='40%' fill='url(#g151)' /> <g stroke='none'> <!-- Stars--> <circle cx='40%' cy='32%' r='.5' fill='grey' /> <circle cx='26%' cy='34%' r='.5' fill='grey' /> <circle cx='34%' cy='42%' r='.5' fill='grey' /> <circle cx='20%' cy='39%' r='.3' fill='grey' /> <circle cx='74%' cy='42%' r='.4' fill='grey' /> <circle cx='49%' cy='20%' r='.2' fill='blue' /> <circle cx='55%' cy='34%' r='.4' fill='grey' /> <circle cx='39%' cy='24%' r='.3' fill='grey' /> <circle cx='55%' cy='14%' r='.4' fill='white' /> <circle cx='57%' cy='22%' r='.3' fill='blue' /> <circle cx='68%' cy='31%' r='.2' fill='white' /> <circle cx='80%' cy='32%' r='.3' fill='yellow' /> <circle cx='42%' cy='44%' r='.5' fill='grey' /> <circle cx='39%' cy='54%' r='.2' fill='white' /> <circle cx='64%' cy='50%' r='.2' fill='white' /> <circle cx='24%' cy='49%' r='.2' fill='white' /> <circle cx='79%' cy='51%' r='.3' fill='white' /> </g> </g>";

    string constant moonStart = "<g transform='scale(0.48) translate(210 170)' stroke='none'><circle cx='81.05%' cy='16.05%' r='53.1' fill='#53676c'/><circle cx='80.95%' cy='15.8%' r='51.2' fill='#A5B6BA'/><circle cx='80.9%' cy='15%' r='46.8' fill='#b7c4c8' /><circle cx='80.3%' cy='13.9%' r='40.6' fill='#dbe3e2' /><circle cx='69.9%' cy='14.3%' r='7' fill='#dbe3e2' /><circle cx='69.9%' cy='14.45%' r='6' fill='#b7c4c8' /><circle cx='82.8%' cy='12.2%' r='16' fill='#b7c4c8' /><circle cx='78.7%' cy='22.3%' r='15.4' fill='#dbe3e2' /><circle cx='78%' cy='22.8%' r='12' fill='#b7c4c8' /><circle cx='73.5%' cy='5.3%' r='3.1' fill='#dbe3e2' /><circle cx='89%' cy='7.5%' r='5.2' fill='#dbe3e2' /><circle cx='91.1%' cy='13.9%' r='8.6' fill='#dbe3e2' /><circle cx='91%' cy='13.96%' r='8' fill='#b7c4c8' /><circle cx='88%' cy='12%' r='3' fill='#b7c4c8' /><circle cx='84%' cy='18.6%' r='5.4' fill='#b7c4c8' /><circle cx='86.5%' cy='22.9%' r='5.3' fill='#dbe3e2' /><circle cx='86.6%' cy='22.9%' r='4.4' fill='#b7c4c8' />";
    string constant moonSmall = "<circle cx='76.6%' cy='12.9%' r='44.4' fill='#000'/>";
    string constant moonMiddle = "<circle cx='70.6%' cy='11.4%' r='44.4' fill='#000'/>";
    string constant moonAlmostFull = "<circle cx='64.6%' cy='8.9%' r='44.4' fill='#000'/>";
    string constant moonEnd = "</g>";

    string constant gridStart = "<g><!-- Grid --><line stroke='purple' x1='139.9%' y1='90%' x2='79.95%' y2='60%' /><line stroke='purple' x1='114.9%' y1='90%' x2='73.45%' y2='60%' /><line stroke='purple' x1='95.9%' y1='90%' x2='67.55%' y2='60%' /><line stroke='purple' x1='83.9%' y1='100%' x2='60.95%' y2='60%' /><line stroke='purple' x1='65.9%' y1='100%' x2='54.55%' y2='60%' /><line stroke='purple' x1='49.9%' y1='100%' x2='48.95%' y2='60%' /><line stroke='purple' x1='34.4%' y1='100%' x2='43.45%' y2='60%' /><line stroke='purple' x1='16.9%' y1='100%' x2='37.95%' y2='60%' /><line stroke='purple' x1='-1.3%' y1='100%' x2='31.95%' y2='60%' /><line stroke='purple' x1='-12%' y1='90%' x2='26%' y2='60%' /><line stroke='purple' x1='-37%' y1='90%' x2='20%' y2='60%' /><line stroke='blue' x1='0%' y1='61.5%' x2='100%' y2='62.5%' /><line stroke='blue' x1='0%' y1='64.5%' x2='100%' y2='65.5%' /><line stroke='blue' x1='0%' y1='70%' x2='100%' y2='71%' /><line stroke='blue' x1='0%' y1='76%' x2='100%' y2='77%' /><line stroke='blue' x1='0%' y1='82.5%' x2='100%' y2='83%' /><line stroke='blue' x1='0%' y1='89.5%' x2='100%' y2='90%' /><line stroke='blue' x1='0%' y1='97%' x2='100%' y2='98%' /><text font-family='WF' font-size='";
    // font size
    string constant gridToText = "' style='fill: #fff;' x='50%' y='59%' dominant-baseline='middle' text-anchor='middle'>";
    // text
    string constant gridEnd = "</text></g></g>";

    string constant flipsStart = "<g><text font-family='WF' font-size='12' letter-spacing='3' style='fill: #fff;'><textPath href='#flips'>";
    // flips
    string constant flipsEnd = " FLIPS</textPath></text></g>";

    string constant orNoLogo = "<g><text font-family='WF' font-size='9' text-align='center' letter-spacing='2.7' style='fill: #fff;'><textPath href='#io'>ORNO.IO</textPath></text></g>";

    string constant svg_yes = "<g class='circle'><text font-family='WF' font-size='33.5' font-weight='500' letter-spacing='4' style='fill: green;'><textPath href='#text'> YES &#160;&#160;#&#160;&#160; YES &#160;&#160;#&#160;&#160; YES &#160;&#160;#&#160;&#160; YES &#160;&#160;#&#160;&#160; YES &#160;&#160;#&#160;&#160; YES &#160;&#160;#&#160;&#160; YES &#160;&#160;#&#160;&#160;</textPath></text></g></svg>";
    string constant svg_no = "<g class='circle'> <text font-family='WF' font-size='32.5' font-weight='500' letter-spacing='4' style='fill: darkred;'> <textPath href='#text'> NO &#160;&#160;#&#160;&#160; NO &#160;&#160;#&#160;&#160; NO &#160;&#160;#&#160;&#160; NO &#160;&#160;#&#160;&#160; NO &#160;&#160;#&#160;&#160; NO &#160;&#160;#&#160;&#160; NO &#160;&#160;#&#160;&#160; NO &#160;&#160;#&#160;&#160;</textPath> </text> </g></svg>";
    
    function svgToImageURI(string memory _text, bool _yesno, uint256 flips) external pure returns (string memory) {
        
        string memory baseURL = "data:image/svg+xml;base64,";
        
        uint256 font_size = fontSize(_text);
        
        string memory yesno = _yesno ? svg_yes : svg_no;
        
        string memory svg__head = string(abi.encodePacked(
            headDefs,
            style,
            stars
        ));

        string memory svg__moon = "";
        
        if(flips >= 25 && flips < 50) {
            svg__moon = string(abi.encodePacked(
                moonStart, moonSmall, moonEnd
            ));
        } else if(flips >= 50 && flips < 75) {
            svg__moon = string(abi.encodePacked(
                moonStart, moonMiddle, moonEnd
            ));
        } else if(flips >= 75 && flips < 100) {
            svg__moon = string(abi.encodePacked(
                moonStart, moonAlmostFull, moonEnd
            ));
        } else if(flips >= 100) {
            svg__moon = string(abi.encodePacked(
                moonStart, moonEnd
            ));
        }
        
        string memory svg__grid = string(abi.encodePacked(
            gridStart, font_size.toString(), gridToText, _text, gridEnd
        ));

        string memory svg__flips = "";

        if(flips < 10) {
            svg__flips = string(abi.encodePacked(
                flipsStart, flips.toString(), flipsEnd,
                orNoLogo,
                yesno
            ));
        } else {
            svg__flips = string(abi.encodePacked(
                flipsStart, flips.toString(), flipsEnd,
                yesno
            ));
        }

        string memory svgBase64Encoded = Base64.encode(bytes(abi.encodePacked(svg__head, svg__moon, svg__grid, svg__flips)));
        string memory imageURI = string(abi.encodePacked(baseURL, svgBase64Encoded));
        return imageURI;
    }
    
    function formatTokenURI(string memory _imageURI) external pure returns (string memory) {
        return string(
            abi.encodePacked(
                "data:application/json;base64,",
                Base64.encode(
                    bytes(
                        abi.encodePacked(
                            '{"name": "OrNo NFT",',
                            '"description": "Coolest thing on the Earth",',
                            '"attributes": "",',
                            '"image": "', _imageURI , '"}'
                        )
                    )
                )
            )
        );       
    }

    function fontSize(string memory _text) internal pure returns(uint256) {
        uint256 textLength = bytes(_text).length;
        if(textLength == 2) {
            return 130;
        }
        if(textLength == 3) {
            return 120;
        }
        if(textLength == 4) {
            return 105;
        }
        if(textLength == 5) {
            return 95;
        }
        if(textLength == 6) {
            return 80;
        }
        if(textLength == 7) {
            return 70;
        }
        if(textLength == 8) {
            return 65;
        }
        if(textLength == 9) {
            return 60;
        }
    }
}